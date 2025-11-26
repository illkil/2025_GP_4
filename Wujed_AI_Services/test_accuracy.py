import pandas as pd
import requests
import time

API_URL = "http://127.0.0.1:8000/classify"

df = pd.read_csv("wujedDataset.csv")

def safe_download(url):
    if not isinstance(url, str):
        return None
        
    url = url.strip()
    if url == "" or url.lower() == "nan":
        return None
    
    try:
        return requests.get(url, timeout=10).content
    except Exception:
        return None


def evaluate(report_type: str):
    predicted_categories = []
    accepted_reports = []
    response_times = []

    print(f"\n--- Evaluating as {report_type.upper()} reports ---")

    if report_type == "lost":
        truth_cat = "true category lost"
        truth_acc = "true accepted reports lost"
        save_cat = "predicted category lost"
        save_acc = "accepted reports lost"
        save_time = "response time lost"
    else:
        truth_cat = "true category found"
        truth_acc = "true accepted reports found"
        save_cat = "predicted category found"
        save_acc = "accepted reports found"
        save_time = "response time found"

    for _, row in df.iterrows():
        item_name = row["item name"]
        item_description = row["item description"]
        image_url1 = row["item image 1"]
        image_url2 = row["item image 2"]

        image_bytes1 = safe_download(image_url1)
        image_bytes2 = safe_download(image_url2)

        files = []
        if image_bytes1:
            files.append(("images", ("img1.jpg", image_bytes1)))
        if image_bytes2:
            files.append(("images", ("img2.jpg", image_bytes2)))

        data = {
            "report_type": report_type,
            "item_name": item_name,
            "item_description": item_description
        }

        start = time.time()

        response = requests.post(API_URL, data=data, files=files)

        end = time.time()

        this_time = end - start
        response_times.append(this_time)

        result = response.json()

        predicted_categories.append(result["category"])
        accepted_reports.append(result["accepted"])


    df[save_cat] = predicted_categories
    df[save_acc] = accepted_reports
    df[save_time] = response_times

    df[f"correct category {report_type}"] = df[save_cat] == df[truth_cat]
    df[f"correct accepted {report_type}"] = df[save_acc] == df[truth_acc]

    accuracyClassification = df[f"correct category {report_type}"].mean() * 100
    accuracyValidation = df[f"correct accepted {report_type}"].mean() * 100
    avg_time = sum(response_times) / len(response_times)

    print(f"Classification Accuracy ({report_type}): {accuracyClassification:.2f}%")
    print(f"Validation Accuracy ({report_type}): {accuracyValidation:.2f}%")
    print(f"Average Response Time ({report_type}): {avg_time:.2f} seconds")

    filename = f"results_{report_type}.csv"
    df.to_csv(filename, index=False)
    print(f"Saved → {filename}\n")

evaluate('lost') #or found