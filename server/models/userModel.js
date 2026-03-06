const db = require('../config/db');

const User = {
  getAll: (callback) => {
    db.query('SELECT * FROM users', callback);
  },

  getById: (id, callback) => {
    db.query('SELECT * FROM users WHERE id = ?', [id], callback);
  },

  create: (userData, callback) => {
    db.query(
      'INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)',
      [userData.name, userData.email, userData.phone, userData.password],
      callback
    );
  },

  update: (id, userData, callback) => {
    db.query(
      'UPDATE users SET name=?, email=?, phone=?, password=? WHERE id=?',
      [userData.name, userData.email, userData.phone, userData.password, id],
      callback
    );
  },

  delete: (id, callback) => {
    db.query('DELETE FROM users WHERE id=?', [id], callback);
  },
};

module.exports = User;