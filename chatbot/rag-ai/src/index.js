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
import { WorkflowEntrypoint } from "cloudflare:workers";

const app = new Hono();

// ==========================
// Mock Data and Utilities
// ==========================

// Mock function to retrieve calendar events
async function getGoogleCalendarEvents() {
  await new Promise((resolve) => setTimeout(resolve, 500));
  return [
    {
      id: "1",
      summary: "Team Meeting",
      start: { dateTime: "2025-04-07T15:00:00Z" }, // 10:00 AM ET (UTC-4)
      end: { dateTime: "2025-04-07T16:00:00Z" },   // 11:00 AM ET (UTC-4)
    },
    {
      id: "2",
      summary: "Lunch with Client",
      start: { dateTime: "2025-04-08T16:00:00Z" }, // 12:00 PM ET (UTC-4)
      end: { dateTime: "2025-04-08T17:00:00Z" },   // 1:00 PM ET (UTC-4)
    },
    {
      id: "3",
      summary: "Project Deadline",
      start: { dateTime: "2025-04-08T13:00:00Z" }, // 9:00 AM ET (UTC-4)
      end: { dateTime: "2025-04-08T21:00:00Z" },   // 5:00 PM ET (UTC-4)
    },
    {
      id: "4",
      summary: "Dinner Date with Sam",
      start: { dateTime: "2025-04-09T23:00:00Z" }, // 7:00 PM ET (UTC-4)
      end: { dateTime: "2025-04-10T00:30:00Z" },   // 8:30 PM ET (UTC-4)
    },
  ];
}

// Mock function to retrieve bank account information
async function getMockedBankAccountInfo(userId) {
  await new Promise((resolve) => setTimeout(resolve, 500));
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

// Mock function to retrieve user goals
async function getMockedGoals(userId) {
  await new Promise((resolve) => setTimeout(resolve, 500));
  return {
    shortTerm: [
      { id: "1", title: "Save $500 for a weekend trip", progress: "70%" },
      { id: "2", title: "Pay off $200 credit card balance", progress: "50%" },
      { id: "3", title: "Buy a new pair of running shoes", progress: "30%" },
    ],
    longTerm: [
      { id: "4", title: "Save $10,000 for a vacation", progress: "40%" },
      { id: "5", title: "Build a $50,000 retirement fund", progress: "20%" },
      { id: "6", title: "Buy a house", progress: "10%" },
    ],
  };
}

// Mock function to retrieve user information

// Future integrations such as skyscanner API to compare the price you've paid for ticket to prices you could get if you trade/exchange them
// Integration with Alpha Vantage to help those new to inventing



// ==========================
// API Routes
// ==========================

// Route: Fetch calendar events
app.get('/calendar-events', async (c) => {
  try {
    const events = await getGoogleCalendarEvents();
    const response = c.json(events);
    response.headers.set("Access-Control-Allow-Origin", "*");
    return response;
  } catch (error) {
    console.error("Error in /calendar-events:", error);
    return c.text("Failed to retrieve calendar events.", 500);
  }
});

// Route: Fetch bank account transactions (negative amounts only)
app.get('/recent-purchases', async (c) => {
  const userId = c.req.query('userId') || 'default';
  try {
    const bankAccountInfo = await getMockedBankAccountInfo(userId);
    const filteredTransactions = bankAccountInfo.transactions.filter(txn => txn.amount < 0);
    const response = c.json(filteredTransactions);
    response.headers.set("Access-Control-Allow-Origin", "*");
    return response;
  } catch (error) {
    console.error("Error in /recent-purchases:", error);
    return c.text("Failed to retrieve recent purchases.", 500);
  }
});

// Route: Fetch user goals
app.get('/goals', async (c) => {
  const userId = c.req.query('userId') || 'default';
  try {
    const goals = await getMockedGoals(userId);
    const response = c.json(goals);
    response.headers.set("Access-Control-Allow-Origin", "*");
    return response;
  } catch (error) {
    console.error("Error in /goals:", error);
    return c.text("Failed to retrieve goals.", 500);
  }
});

// Route: Add a new note
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

// Route: Test MongoDB connection
app.get('/test-db-connection', async (c) => {
  try {
    const documents = await queryMongoAllDocuments(c.env);
    if (documents.length > 0) {
      return c.text(`Documents found:\n\n${JSON.stringify(documents, null, 2)}`);
    } else {
      return c.text("No documents found.");
    }
  } catch (error) {
    console.error("Error in /test-db-connection:", error);
    return c.text("Failed to connect to the database.", 500);
  }
});

// Route: What-if mode
app.get('/what-if', async (c) => {
  const userId = c.req.query('userId') || 'default';
  const scenario = c.req.query('scenario') || '';


});

// Route: Generate daily/weekly quests
app.get('/quests', async (c) => {
  const userId = c.req.query('userId') || 'default';

  try {
    const bankAccountInfo = await getMockedBankAccountInfo(userId);
    const userGoals = await getMockedGoals(userId);
    const calendarEvents = await getGoogleCalendarEvents();

    const quests = generateQuests(bankAccountInfo, userGoals, calendarEvents);

    const response = c.json(quests);
    response.headers.set("Access-Control-Allow-Origin", "*");
    return response;
  } catch (error) {
    console.error("Error in /quests:", error);
    return c.text("Failed to generate quests.", 500);
  }
});


// ==========================
// Helper Functions
// ==========================

async function queryMongoAllDocuments(env) {
  const res = await fetch(`https://data.mongodb-api.com/app/${env.MONGO_APP_ID}/endpoint/data/v1/action/find`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'api-key': env.MONGO_API_KEY,
    },
    body: JSON.stringify({
      dataSource: 'Cluster0',
      database: 'wehack',
      collection: 'notes',
      filter: {},
    }),
  });

  const json = await res.json();
  return json?.documents || [];
}

// ==========================
// Chatbot Logic
// ==========================

const chatHistory = {};

async function generateContext(userId) {
  let calendarEvents = [];
  try {
    calendarEvents = await getGoogleCalendarEvents();
  } catch (error) {
    console.error("Error fetching calendar events:", error);
  }

  const calendarContext = calendarEvents.length
    ? `Upcoming Events:\n${calendarEvents
        .map((event) => `- ${event.summary} from ${event.start.dateTime} to ${event.end.dateTime}`)
        .join("\n")}`
    : "No upcoming events.";

  let bankAccountInfo = {};
  try {
    bankAccountInfo = await getMockedBankAccountInfo(userId);
  } catch (error) {
    console.error("Error fetching bank account information:", error);
  }

  const bankAccountContext = `
  Bank Account Information:
  - Account Holder: ${bankAccountInfo.accountHolder}
  - Account Number: ${bankAccountInfo.accountNumber}
  - Balance: $${bankAccountInfo.balance.toFixed(2)}
  Transactions:
  ${bankAccountInfo.transactions
    .map((txn) => `  - ${txn.date}: ${txn.description} (${txn.amount < 0 ? "-" : "+"}$${Math.abs(txn.amount).toFixed(2)})`)
    .join("\n")}`;

  let userGoals = [];
  try {
    userGoals = await getMockedGoals(userId);
  } catch (error) {
    console.error("Error fetching user goals:", error);
  }

  const goalsContext = userGoals.length
    ? `User Goals:\n${userGoals
        .map((goal) => `- Goal: ${goal.title}, Progress: ${goal.progress}`)
        .join("\n")}`
    : "No goals set.";

  const userState = "California";
  const userInfo = `User Information:\n- State: ${userState}`;

  return [calendarContext, userInfo, bankAccountContext, goalsContext]
    .filter(Boolean)
    .join("\n\n");
}
function generateQuests(bankAccountInfo, userGoals, calendarEvents) {
  const quests = [];

  // Quest 1: Save money by reducing spending
  const recentExpenses = bankAccountInfo.transactions.filter(txn => txn.amount < 0);
  const totalExpenses = recentExpenses.reduce((sum, txn) => sum + Math.abs(txn.amount), 0);
  if (totalExpenses > 100) {
    quests.push({
      title: "Reduce Spending",
      description: "Try to spend $20 less this week by avoiding unnecessary purchases.",
      action: "Track your expenses and skip one non-essential purchase this week.",
    });
  }

  // Quest 2: Progress on short-term goals
  const shortTermGoal = userGoals.shortTerm.find(goal => goal.progress !== "100%");
  if (shortTermGoal) {
    quests.push({
      title: `Work on Your Goal: ${shortTermGoal.title}`,
      description: `You're ${shortTermGoal.progress} complete. Take one step today to get closer to achieving this goal.`,
      action: "Set aside some time or money to make progress on this goal.",
    });
  }

  // Quest 3: Add a new productive habit
  const hasLearningEvent = calendarEvents.some(event => event.summary.toLowerCase().includes("learning"));
  if (!hasLearningEvent) {
    quests.push({
      title: "Add a Learning Habit",
      description: "Spend 30 minutes today learning something new to improve your skills.",
      action: "Add a 'Learning Time' event to your calendar and stick to it.",
    });
  }

  // Quest 4: Plan for upcoming events
  const upcomingEvent = calendarEvents.find(event => new Date(event.start.dateTime) > new Date());
  if (upcomingEvent) {
    quests.push({
      title: "Prepare for Your Next Event",
      description: `You have an upcoming event: "${upcomingEvent.summary}". Make sure you're ready.`,
      action: "Review your schedule and prepare any materials or tasks needed for this event.",
    });
  }

  return quests;
}

// Route: Chatbot main logic
app.get('/', async (c) => {
  const userId = c.req.query('userId') || 'default';
  const question = c.req.query('text') || "Am I on track to reach my financial goals based on the provided goals and progress?";

  const userChatHistory = chatHistory[userId] || [];

  let calendarEvents = [];
  try {
    calendarEvents = await getGoogleCalendarEvents();
  } catch (error) {
    console.error("Error fetching calendar events:", error);
  }

  const calendarContext = calendarEvents.length
    ? `Upcoming Events:\n${calendarEvents
        .map((event) => `- ${event.summary} from ${event.start.dateTime} to ${event.end.dateTime}`)
        .join("\n")}`
    : "No upcoming events.";

  let bankAccountInfo = {};
  try {
    bankAccountInfo = await getMockedBankAccountInfo(userId);
  } catch (error) {
    console.error("Error fetching bank account information:", error);
  }

  const bankAccountContext = `
Bank Account Information:
- Account Holder: ${bankAccountInfo.accountHolder}
- Account Number: ${bankAccountInfo.accountNumber}
- Balance: $${bankAccountInfo.balance.toFixed(2)}
Transactions:
${bankAccountInfo.transactions
  .map((txn) => `  - ${txn.date}: ${txn.description} (${txn.amount < 0 ? "-" : "+"}$${Math.abs(txn.amount).toFixed(2)})`)
  .join("\n")}`;

  const userState = "California";
  const userInfo = `User Information:\n- State: ${userState}`;

  let userGoals = [];
  try {
    userGoals = await getMockedGoals(userId);
  } catch (error) {
    console.error("Error fetching user goals:", error);
  }

  const goalsContext = userGoals.length
    ? `User Goals:\n${userGoals
        .map((goal) => `- Goal: ${goal.title}, Progress: ${goal.progress}`)
        .join("\n")}`
    : "No goals set.";

  const limitedChatHistory = userChatHistory.slice(-5);
  const formattedChatHistory = limitedChatHistory.length
    ? limitedChatHistory.map((msg) => ({
        role: msg.role,
        content: msg.content,
      }))
    : [];

  const contextMessage = [
    calendarContext,
    userInfo,
    bankAccountContext,
    goalsContext,
  ]
    .filter(Boolean)
    .join("\n\n");

  const systemPrompt = `Your name is Penny. You are a financial advisor. Use the provided context, including the user's financial goals and their progress, to evaluate whether the user is on track to reach their goals. Provide a clear and concise assessment based on the context. Limit your response to 150 words.`;

  const { response: answer } = await c.env.AI.run('@cf/meta/llama-3-8b-instruct', {
    messages: [
      { role: 'system', content: systemPrompt },
      { role: 'system', content: contextMessage },
      ...formattedChatHistory,
      { role: 'user', content: question },
    ],
  });
  
  // Limit the response to 150 words
  const responseText = answer.split(' ').slice(0, 150).join(' ');

  if (!chatHistory[userId]) chatHistory[userId] = [];
  chatHistory[userId].push({ role: 'user', content: question });
  chatHistory[userId].push({ role: 'assistant', content: answer });

  const response = c.text(responseText);
  response.headers.set("Access-Control-Allow-Origin", "*");
  response.headers.set("Access-Control-Allow-Methods", "GET, POST");
  response.headers.set("Access-Control-Allow-Headers", "Content-Type, Authorization");
  return response;
});

// ==========================
// Error Handling
// ==========================

app.onError((err, c) => {
  console.error("Unhandled error:", err);
  return c.text("An unexpected error occurred.", 500);
});

// ==========================
// Workflow Entrypoint
// ==========================

export class RAGWorkflow extends WorkflowEntrypoint {
  async run(event, step) {
    const env = this.env;
    const { text } = event.payload;

    const record = await step.do(`create database record`, async () => {
      const query = "INSERT INTO notes (text) VALUES (?) RETURNING *";

      const { results } = await env.DB.prepare(query).bind(text).run();

      const record = results[0];
      if (!record) throw new Error("Failed to create note");
      return record;
    });

    const embedding = await step.do(`generate embedding`, async () => {
      const embeddings = await env.AI.run('@cf/baai/bge-base-en-v1.5', { text: text });
      const values = embeddings.data[0];
      if (!values) throw new Error("Failed to generate vector embedding");
      return values;
    });

    await step.do(`insert vector`, async () => {
      return env.VECTOR_INDEX.upsert([
        {
          id: record.id.toString(),
          values: embedding,
        },
      ]);
    });
  }
}

// ==========================
// Export App
// ==========================

export default app;
