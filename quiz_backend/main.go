package main

import (
    "encoding/json"
    "net/http"
)

// Question represents a quiz question with options
type Question struct {
    Question             string   `json:"question"`
    Options            []string   `json:"options"`
    CorrectAnswerIndex      int   `json:"correctAnswerIndex"`
    ImageURL             string   `json:"imageUrl,omitempty"`
}

// getQuestions returns a list of quiz questions
func getQuestions(w http.ResponseWriter, r *http.Request) {
    questions := []Question{
        {
            Question: "What is the capital of France?",
            Options:  []string{"Paris", "London", "Berlin", "Madrid"},
            CorrectAnswerIndex: 0,
            ImageURL: "https://www.frenchlearner.com/wp-content/uploads/2023/02/france-second-republic-flag-1.png", 
        },
        {
            Question: "Which binary operator is used to toggle a bit in programming?",
            Options:  []string{"OR", "XOR", "AND", "You can't toggle a bit"},
            CorrectAnswerIndex: 1,
        },
        {
            Question: "What is the sum of the interior angles of a hexagon?",
            Options:  []string{"360", "540", "980", "720"},
            CorrectAnswerIndex: 3, 
            ImageURL: "https://images.twinkl.co.uk/tw1n/image/private/t_630/u/ux/hex_ver_1.png", 
        },
        {
            Question: "What is the time complexity of a binary search algorithm?",
            Options:  []string{"O(n/2)", "O(n)", "O(log(n))", "O(nlog(n))"},
            CorrectAnswerIndex: 2,
        },
        {
            Question: "Who is known as the father of computers?",
            Options:  []string{"Ryan Reynolds", "Alan Turing", "Charles Babbage", "Bill Gates"},
            CorrectAnswerIndex: 0,
        },
        {
            Question: "Which of the following algorithms has the worst time complexity?",
            Options:  []string{"Merge Sort", "Bubble Sort", "Quick Sort", "Heap sort"},
            CorrectAnswerIndex: 1,
        },
        {
            Question: "What is the largest desert in the world?",
            Options:  []string{"Sahara", "Arctic Desert", "Kalahari", "Gobi"},
            CorrectAnswerIndex: 1,
        },
        {
            Question: "Which river is the longest in the world?",
            Options:  []string{"Nile", "Yangtze", "Amazon", "Mississippi"},
            CorrectAnswerIndex: 0, 
            ImageURL: "https://cdn.serc.carleton.edu/images/integrate/teaching_materials/water_science_society/student_materials/egypt_ampamp_northern_red_744.webp", 
        },
        {
            Question: "Which country has the most time zones?",
            Options:  []string{"Russia", "United States", "China", "Brazil"},
            CorrectAnswerIndex: 0,
        },
        {
            Question: "Mount Everest is located in which mountain range?",
            Options:  []string{"Andes", "Alps", "Himalayas", "Rockies"},
            CorrectAnswerIndex: 2, 
            ImageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg/2560px-Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg", 
        },
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(questions)
}

func main() {
    http.HandleFunc("/questions", getQuestions)
    http.ListenAndServe(":8080", nil)
}
