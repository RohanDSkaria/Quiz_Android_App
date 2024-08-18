package main

import (
    "encoding/json"
    "net/http"
)

// Question represents a quiz question with options
type Question struct {
    Question        string   `json:"question"`
    Options         []string `json:"options"`
    CorrectAnswerIndex int `json:"correctAnswerIndex"` // Change to store index
}

// getQuestions returns a list of quiz questions
func getQuestions(w http.ResponseWriter, r *http.Request) {
    questions := []Question{
        {
            Question: "What is the capital of France?",
            Options:  []string{"Paris", "London", "Berlin", "Madrid"},
            CorrectAnswerIndex: 0, // Index of "Paris"
        },
        {
            Question: "Which binary operator is used to toggle a bit in programming?",
            Options:  []string{"OR", "XOR", "AND", "You can't toggle a bit"},
            CorrectAnswerIndex: 1, // Index of "XOR"
        },
        {
            Question: "What is the sum of the interior angles of a hexagon?",
            Options:  []string{"360", "540", "980", "720"},
            CorrectAnswerIndex: 3, // Index of "720"
        },
        {
            Question: "What is the time complexity of a binary search algorithm?",
            Options:  []string{"O(n/2)", "O(n)", "O(log(n))", "O(nlog(n))"},
            CorrectAnswerIndex: 2, // Index of "O(log(n))"
        },
        {
            Question: "Who is known as the father of computers?",
            Options:  []string{"Ryan Reynolds", "Alan Turing", "Charles Babbage", "Bill Gates"},
            CorrectAnswerIndex: 0, // Index of "Charles Babbage"
        },
        {
            Question: "Which of the following algorithms has the worst time complexity?",
            Options:  []string{"Merge Sort", "Bubble Sort", "Quick Sort", "Heap sort"},
            CorrectAnswerIndex: 1, // Index of "Bubble Sort"
        },
        {
            Question: "What is the largest desert in the world?",
            Options:  []string{"Sahara", "Arctic Desert", "Kalahari", "Gobi"},
            CorrectAnswerIndex: 1, // Index of "Arctic Desert"
        },
        {
            Question: "Which river is the longest in the world?",
            Options:  []string{"Nile", "Yangtze", "Amazon", "Mississippi"},
            CorrectAnswerIndex: 0, // Index of "Nile"
        },
        {
            Question: "Which country has the most time zones?",
            Options:  []string{"Russia", "United States", "China", "Brazil"},
            CorrectAnswerIndex: 0, // Index of "Russia"
        },
        {
            Question: "Mount Everest is located in which mountain range?",
            Options:  []string{"Andes", "Alps", "Himalayas", "Rockies"},
            CorrectAnswerIndex: 2, // Index of "Himalayas"
        },
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(questions)
}

func main() {
    http.HandleFunc("/questions", getQuestions)
    http.ListenAndServe(":8080", nil)
}
