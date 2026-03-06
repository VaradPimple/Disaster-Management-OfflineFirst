const db = require('../config/db');

// Get all users
exports.getAllUsers = (req, res) => {
  db.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error('Database query error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    res.json(results);
  });
};

// Create a new user
exports.createUser = (req, res) => {
  const { name, email, phone, password } = req.body;
  db.query(
    'INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)',
    [name, email, phone, password],
    (err, results) => {
      if (err) {
        console.error('Database insert error:', err);
        return res.status(500).json({ error: 'Failed to create user' });
      }
      res.json({ message: 'User created', userId: results.insertId });
    }
  );
};