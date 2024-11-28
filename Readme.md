# Fruits and Vegetables Recognition App

This project is a **Fruits and Vegetables Recognition App** built with **SwiftUI** for the frontend and **Python (TensorFlow)** for training the machine learning model. The app can classify images of fruits and vegetables into **36 categories** with high accuracy, leveraging a custom-trained model based on the [Fruits and Vegetables Image Recognition Dataset](https://www.kaggle.com/datasets/kritikseth/fruit-and-vegetable-image-recognition).

---

## **Developer Information**

- **Developer Name**: Keshan Weerasekara
- **IT Number**: IT21047756

---

## **Dataset Information**

The model was trained using the **Fruits and Vegetables Image Recognition Dataset** available on Kaggle. The dataset contains images of **36 classes** of fruits and vegetables:

- **Classes**:  
  `apple`, `banana`, `beetroot`, `bell pepper`, `cabbage`, `capsicum`, `carrot`, `cauliflower`, `chilli pepper`, `corn`, `cucumber`, `eggplant`, `garlic`, `ginger`, `grapes`, `jalepeno`, `kiwi`, `lemon`, `lettuce`, `mango`, `onion`, `orange`, `paprika`, `pear`, `peas`, `pineapple`, `pomegranate`, `potato`, `raddish`, `soy beans`, `spinach`, `sweetcorn`, `sweetpotato`, `tomato`, `turnip`, `watermelon`.

---

## **Technologies Used**

1. **Frontend**: SwiftUI for building the user interface.
2. **Backend**: Python for training the machine learning model.
3. **Machine Learning Framework**: TensorFlow for creating and training the classification model.
4. **Help**: ChatGPT was used for guidance during development.

---

## **Features**

- **Image Classification**: Upload or capture an image of a fruit or vegetable, and the app will classify it into one of 36 categories.
- **SwiftUI Interface**: A modern and responsive interface for seamless user experience.
- **Custom-trained Model**: A TensorFlow model trained on a Kaggle dataset, ensuring high accuracy.

---

## **Screenshots**

Below are some screenshots from the app to showcase its functionality:

| Screenshot                                                                                                                                                                                                                                 | Description                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------- |
| ![Screenshot 1](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.22.48.png?alt=media&token=b5334e7b-3dd8-4e2e-8fa8-dc6f6b44a46f) | App home screen showcasing navigation options.     |
| ![Screenshot 2](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.22.50.png?alt=media&token=2d2658ea-d7ef-4a77-a188-fd1ef77adca1) | Upload image feature for selecting an image.       |
| ![Screenshot 3](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.22.52.png?alt=media&token=10c2ea6e-5be7-4520-81e5-5a0b3298b55d) | Live camera input for real-time image recognition. |
| ![Screenshot 4](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.23.22.png?alt=media&token=1129df0f-dec9-4062-92ff-ac1247aa18bc) | Results screen displaying the recognized class.    |
| ![Screenshot 5](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.23.24.png?alt=media&token=6e54295f-d03b-4815-87bd-81157e35aaa2) | Detailed information about the recognized class.   |
| ![Screenshot 6](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.23.32.png?alt=media&token=c2e93710-fad7-46ef-9870-c84763a31e7c) | Options for saving or sharing the result.          |
| ![Screenshot 7](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.23.35.png?alt=media&token=275b88ec-fd23-4477-8283-29bd60358f42) | Error handling for unrecognized images.            |
| ![Screenshot 8](https://firebasestorage.googleapis.com/v0/b/kavinda-f44d7.appspot.com/o/keshan%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-11-28%20at%2021.23.44.png?alt=media&token=6532f63d-84fd-4584-837c-4a5f73567cd3) | App settings screen.                               |

---

## **How to Train the Model**

1. **Dataset**: Download the dataset from [Kaggle](https://www.kaggle.com/datasets/kritikseth/fruit-and-vegetable-image-recognition).
2. **Python Script**: A Python script using TensorFlow was developed to preprocess the dataset and train a classification model.
3. **Model Architecture**: The model uses convolutional layers with ReLU activation functions, followed by fully connected layers for classification.

---

## **How to Run the App**

1. Clone this repository.
2. Open the project in Xcode.
3. Build and run the app on the iOS simulator or a connected device.

---

## **Future Enhancements**

- Include additional datasets for broader classification.
- Add support for live recognition using ARKit.
- Implement cloud-based model inference for enhanced performance on low-end devices.

---

## **Acknowledgments**

- [Kaggle](https://www.kaggle.com/datasets/kritikseth/fruit-and-vegetable-image-recognition) for the dataset.
- **ChatGPT** for assisting in developing the app and writing this README.
