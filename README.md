# data_ai_chatbot
# PDF AI Chat

## Objective
The PDF AI Chat project aims to provide users with an interactive platform to query multiple PDF documents simultaneously. It leverages advanced AI and machine learning models provided by Langchain and OpenAI to extract, index, and retrieve information from uploaded PDFs, enabling a conversational interface for document interaction.

## System Architecture
The system is comprised of:
- **Frontend:** Developed using Flutter, providing functionalities for uploading PDFs, sending queries, and displaying responses.
- **Backend:** Utilizes Langchain for document processing and embedding, Pinecone as a vector database for efficient information retrieval, and OpenAI models for generating embeddings and answering user queries.

## Key Components
1. **HomeScreen**: Main interface for user interaction.
2. **LangchainService**: Manages document processing and Pinecone database interactions.
3. **Providers and Notifiers**: For state management and UI-backend communication.

## Dependencies and Packages
- **flutter_riverpod/hooks_riverpod**: State management.
- **flutter_hooks**: Widget lifecycle management.
- **langchain/langchain_openai/langchain_pinecone**: Document processing and embedding.
- **pinecone**: Vector database client.
- **syncfusion_flutter_pdf**: PDF processing.
- **dotenv**: Environment variable management.
- Additional UI and utility packages like `path_provider`, `sqflite`, etc.

## Application Flow
- **PDF Upload**: Process and index uploaded PDFs into Pinecone.
- **Query Processing**: Embed user queries and search against indexed documents.
- **Response Generation**: Retrieve relevant sections and generate conversational responses.

## Code Explanation

### HomeScreen
The `HomeScreen` widget, built with Flutter, serves as the user interface, supporting PDF uploads and query inputs. It uses `flutter_hooks` for text controller management and `hooks_riverpod` for reactive state management.

### Langchain Service Implementation
`LangchainServiceImpl` integrates with Langchain, Pinecone, and OpenAI services, handling document indexing, querying, and response generation. It utilizes the `langchain_openai` and `langchain_pinecone` packages for embedding and indexing functionalities.

### State Management
The application employs Riverpod for decoupled and testable state management, with specific notifiers for chat, index, and query states, facilitating a clean architecture.

## Usefulness
This application provides a novel way to interact with PDF documents, making it ideal for those needing to efficiently manage and query large volumes of text data. Its conversational interface simplifies information retrieval using natural language queries, benefiting researchers, students, and professionals alike.

