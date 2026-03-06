const express = require('express');
const cors = require('cors');
require('dotenv').config();

// ✅ Import the database connection
const db = require('./config/db');

const disasterRoutes = require('./routes/disasterRoutes');
const sosRoutes = require('./routes/sosRoutes');
const userRoutes = require('./routes/userRoutes');
const alertRoutes = require('./routes/alertRoutes');

const app = express();

// Enable CORS
app.use(cors());

// Parse JSON bodies
app.use(express.json());

// Routes
app.use('/api/disasters', disasterRoutes);
app.use('/api/sos', sosRoutes);
app.use('/api/users', userRoutes);
app.use('/api/alerts', alertRoutes);

// Health check route
app.get('/', (req, res) => {
  res.send('Disaster Management API Running');
});

// ✅ Listen on all network interfaces
const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});