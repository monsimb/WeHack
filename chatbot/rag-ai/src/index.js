/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 * npx wrangler deploy
 */

import { Hono } from "hono";

const app = new Hono();


async function queryMongoAllDocuments(env) {
  const vecId = "67f1cb1c2a24ec438ee77d52";  // The specific document ID
  const res = await fetch(`https://data.mongodb-api.com/app/${env.MONGO_APP_ID}/endpoint/data/v1/action/find`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'api-key': 'mongodb+srv://db_user:e0UK8RNjUlJqCHmZ@cluster0.mbfcuye.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0/notes',
    },
    body: JSON.stringify({
      dataSource: 'Cluster0',  // MongoDB cluster name from environment variable
      database: 'wehack',        // MongoDB database name from environment variable
      collection: 'notes',  // MongoDB collection name from environment variable
      filter: {},  // Filter with the specific document ID
    }),
  });

  const json = await res.json();
  return json?.document || [];
}

// Existing route for testing DB connection
app.get('/test-db-connection', async (c) => {
  const documents = await queryMongoAllDocuments(c.env);
  if (documents.length > 0) {
    return c.text(`Documents found:\n\n${JSON.stringify(documents, null, 2)}`);
  } else {
    return c.text("No documents found.");
  }
});







// Mock function to retrieve calendar events
async function getGoogleCalendarEvents() {
  try {
    // Simulate a delay to mimic an API call
    await new Promise((resolve) => setTimeout(resolve, 500));

    // Return mocked calendar events
    return [
      {
        id: "1",
        summary: "Team Meeting",
        start: { dateTime: "2025-04-07T10:00:00Z" },
        end: { dateTime: "2025-04-08T11:00:00Z" },
      },
      {
        id: "2",
        summary: "Lunch with Client",
        start: { dateTime: "2025-04-08T12:00:00Z" },
        end: { dateTime: "2025-04-08T13:00:00Z" },
      },
      {
        id: "3",
        summary: "Project Deadline",
        start: { dateTime: "2025-04-08T09:00:00Z" },
        end: { dateTime: "2025-04-08T17:00:00Z" },
      },
    ];
  } catch (error) {
    console.error("Error fetching mocked Google Calendar events:", error);
    throw new Error("Failed to retrieve mocked calendar events.");
  }
}

// Example route to fetch mocked calendar events -> would come from google Calendar API (Auth0 integration)
app.get('/calendar-events', async (c) => {
  const apiKey = c.req.query('apiKey'); // Get the API key from the query parameters

  try {
    const events = await getGoogleCalendarEvents(apiKey);
    return c.json(events);
  } catch (error) {
    return c.text(error.message, 500);
  }
});

// Mock function to retrieve bank account information
async function getMockedBankAccountInfo(userId) {
  // Simulate a delay to mimic an API call
  await new Promise((resolve) => setTimeout(resolve, 500));

  // Return mocked bank account information
  return {
    accountNumber: "123456789",
    accountHolder: userId || "Default User",
    balance: 4523.75,
    transactions: [
      { date: "2025-04-01", description: "Grocery Store", amount: -45.67 },
      { date: "2025-04-03", description: "Salary Deposit", amount: 3000.00 },
      { date: "2025-04-05", description: "Electricity Bill", amount: -120.50 },
      { date: "2025-04-10", description: "Coffee Shop", amount: -8.75 },
      { date: "2025-04-15", description: "Gym Membership", amount: -50.00 },
      { date: "2025-04-20", description: "Online Shopping", amount: -200.00 },
      { date: "2025-04-25", description: "Restaurant", amount: -75.25 },
      { date: "2025-04-28", description: "Car Payment", amount: -300.00 },
    ],
  };
}



const chatHistory = {};

// Main route for the chatbot
// This route handles incoming requests to the chatbot and returns a response based on the user's input
app.get('/', async (c) => {
  const userId = c.req.query('userId') || 'default'; // Use a userId to track individual chat histories
  const question = c.req.query('text') || "what can you do?";

  // Retrieve the user's chat history
  const userChatHistory = chatHistory[userId] || [];


  // Fetch mocked calendar events
  let calendarEvents = [];
  try {
    calendarEvents = await getGoogleCalendarEvents();
  } catch (error) {
    console.error("Error fetching calendar events:", error);
  }
  // Format calendar events as context
  const calendarContext = calendarEvents.length
  ? `Upcoming Events:\n${calendarEvents
      .map(
        (event) =>
          `- ${event.summary} from ${event.start.dateTime} to ${event.end.dateTime}`
      )
      .join("\n")}`
  : "No upcoming events.";
  // Fetch mocked bank account information
let bankAccountInfo = {};
try {
  bankAccountInfo = await getMockedBankAccountInfo(userId);
} catch (error) {
  console.error("Error fetching bank account information:", error);
}

// Format bank account information as context
const bankAccountContext = `
Bank Account Information:
- Account Holder: ${bankAccountInfo.accountHolder}
- Account Number: ${bankAccountInfo.accountNumber}
- Balance: $${bankAccountInfo.balance.toFixed(2)}
Transactions:
${bankAccountInfo.transactions
  .map(
    (txn) =>
      `  - ${txn.date}: ${txn.description} (${txn.amount < 0 ? "-" : "+"}$${Math.abs(txn.amount).toFixed(2)})`
  )
  .join("\n")}
`;





  // Add user-specific information (e.g., state they live in)
  const userState = "California"; // Replace with dynamic retrieval logic if needed
  const userInfo = `User Information:\n- State: ${userState}`;


  // Combine chat history and calendar events into the context message
  const contextMessage = [
  userChatHistory.length
    ? `Chat History:\n${userChatHistory
        .map((msg, index) => `${index + 1}. ${msg}`)
        .join("\n")}`
    : "",
  calendarContext,
  userInfo,
  bankAccountContext,
  ]
  .filter(Boolean)
  .join("\n\n");

  const systemPrompt = `Your name is Penny. You are a financial advisor. When answering the question or responding, use the context provided, if it is provided and relevant.`;

  const { response: answer } = await c.env.AI.run('@cf/meta/llama-3-8b-instruct', {
  messages: [
    ...(contextMessage ? [{ role: 'system', content: contextMessage }] : []),
    { role: 'system', content: systemPrompt },
    { role: 'user', content: question }
  ]
  });


  const responseText = `
  
  ${answer}
  `;

  // Update the user's chat history
  if (!chatHistory[userId]) chatHistory[userId] = [];
  chatHistory[userId].push(question);

  const response = c.text(responseText);
  response.headers.set("Access-Control-Allow-Origin", "*");
  response.headers.set("Access-Control-Allow-Methods", "GET, POST");
  response.headers.set("Access-Control-Allow-Headers", "Content-Type, Authorization");
  return response;
});

app.post('/notes', async (c) => {
	const { text } = await c.req.json();
	if (!text) return c.text("Missing text", 400);

	await c.env.RAG_WORKFLOW.create({ params: { text } });
	const response = c.text("Created note", 201);
  response.headers.set("Access-Control-Allow-Origin", "*");
  response.headers.set("Access-Control-Allow-Methods", "GET, POST");
  response.headers.set("Access-Control-Allow-Headers", "Content-Type, Authorization");
  return response;

	});
  

app.onError((err, c) => {
  return c.text(err);
});

export default app;

import { WorkflowEntrypoint } from "cloudflare:workers";

export class RAGWorkflow extends WorkflowEntrypoint {
  async run(event, step) {
    const env = this.env
    const { text } = event.payload

    const record = await step.do(`create database record`, async () => {
      const query = "INSERT INTO notes (text) VALUES (?) RETURNING *"

      const { results } = await env.DB.prepare(query)
        .bind(text)
        .run()

      const record = results[0]
      if (!record) throw new Error("Failed to create note")
      return record;
    })

    const embedding = await step.do(`generate embedding`, async () => {
      const embeddings = await env.AI.run('@cf/baai/bge-base-en-v1.5', { text: text })
      const values = embeddings.data[0]
      if (!values) throw new Error("Failed to generate vector embedding")
      return values
    })

    await step.do(`insert vector`, async () => {
      return env.VECTOR_INDEX.upsert([
        {
          id: record.id.toString(),
          values: embedding,
        }
      ]);
    })
  }
}



