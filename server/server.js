const express = require('express');
const cors = require('cors');
require('dotenv').config();

const disasterRoutes = require('./routes/disasterRoutes');
const sosRoutes = require('./routes/sosRoutes');
const userRoutes = require('./routes/userRoutes');
const alertRoutes = require('./routes/alertRoutes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/disasters', disasterRoutes);
app.use('/api/sos', sosRoutes);
app.use('/api/users', userRoutes);
app.use('/api/alerts', alertRoutes);

// ✅ ADD THIS
app.get('/', (req, res) => {
  res.send('Disaster Management API Running');
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});