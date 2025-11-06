from fastapi import FastAPI
from pydantic import BaseModel
from google.cloud import vision
from openai import OpenAI
import requests
import os

#os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "wujed.json" #google cloud service account key

client = OpenAI(api_key="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")
#openAI key from gpgroud.agr@gmail.com account

vision_client = vision.ImageAnnotatorClient() #google vision client

app = FastAPI() #initilaization for fastAPI (server)

CATEGORIES = [ #predefined categories
    "electronics",
    "clothing",
    "bags and wallets",
    "documents and ids",
    "keys",
    "cosmetics and personal care",
    "jewelry",
    "others"
]

class ClassifyRequest(BaseModel): #define what is sent from client side (images and description)
    image_urls: list[str]
    description: str

@app.post("/classify") #create post endpoint
def classify(request: ClassifyRequest):
    all_labels = [] #to store all labels from 2 images

    for url in request.image_urls: #loop to get labels for the 2 images
        #download each image
        image_content = requests.get(url).content
        image = vision.Image(content=image_content) #make image google vision compatible

        #run Google Vision on each image
        response = vision_client.label_detection(image=image) #send image to google vision to get labels
        labels = [label.description for label in response.label_annotations] #extract lables from response
        all_labels.extend(labels) #add labels to list

    #remove duplicate labels
    unique_labels = list(dict.fromkeys(all_labels))

    #GPT classification
    prompt = f"""
    You are an AI assistant for a Lost & Found app.
    Description: {request.description}
    Combined labels from multiple images: {unique_labels}
    Choose the best category from: {CATEGORIES}
    Return only the category name.
    """

    chat = client.chat.completions.create( #send prompt to gpt-4o-mini
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
    )

    category = chat.choices[0].message.content.strip() #get category from gpt
    return {"category": category, "labels": unique_labels} #return category and labels just incase
