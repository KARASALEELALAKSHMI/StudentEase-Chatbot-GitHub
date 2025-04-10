from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, db
from sentence_transformers import SentenceTransformer, util
import ollama

app = Flask(__name__)

# Initialize Firebase
cred = credentials.Certificate(r"C:\Users\t470p\Desktop\tourist chatbot\firebase_credentials.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://stdease-9c8d6-default-rtdb.firebaseio.com/'
})

# Load the SentenceTransformer model
model = SentenceTransformer('paraphrase-MiniLM-L6-v2')

# Fetch data from Firebase
def fetch_firebase_data():
    ref = db.reference("updates")
    data = ref.get()
    if not data:
        return []
    return [{"headline": item["headline"], "content": item["content"]} for item in data.values()]

# Encode headlines
firebase_data = fetch_firebase_data()
for item in firebase_data:
    item["headline_embedding"] = model.encode(item["headline"], convert_to_tensor=True)

# Find most similar headline
def find_most_similar_content(user_question):
    user_question_embedding = model.encode(user_question, convert_to_tensor=True)
    similarities = [(util.pytorch_cos_sim(user_question_embedding, item["headline_embedding"]).item(), item) for item in firebase_data]
    most_similar = max(similarities, key=lambda x: x[0])
    return most_similar[1]["headline"], most_similar[1]["content"]

# Generate Ollama response
def generate_ollama_response(chat_history, relevant_content):
    prompt = "This is a conversation between a user and an educational guidance chatbot.\n"
    for entry in chat_history:
        prompt += f"User: {entry['user']}\nBot: {entry['bot']}\n"
    prompt += f"User: {chat_history[-1]['user']}\n"
    prompt += f"Based on the following information: \"{relevant_content}\", provide a professional response.\nBot:"
    response = ollama.chat(model="tinyllama", messages=[{"role": "user", "content": prompt}])
    return response['message']['content']

@app.route('/ask', methods=['POST'])
def ask_question():
    data = request.get_json()
    user_question = data.get("question")
    if not user_question:
        return jsonify({"error": "Question is required"}), 400
    
    relevant_headline, relevant_content = find_most_similar_content(user_question)
    chat_history = [{"user": user_question, "bot": relevant_content}]
    enhanced_answer = generate_ollama_response(chat_history, relevant_content)
    chat_history[-1]['bot'] = enhanced_answer
    
    return jsonify({"user": user_question, "bot": enhanced_answer})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)

