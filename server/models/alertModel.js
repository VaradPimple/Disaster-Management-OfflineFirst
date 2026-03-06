const db = require('../config/db');

const Alert = {
  getAll: (callback) => {
    db.query('SELECT * FROM alerts', callback);
  },

  getById: (id, callback) => {
    db.query('SELECT * FROM alerts WHERE id = ?', [id], callback);
  },

  create: (alertData, callback) => {
    db.query(
      'INSERT INTO alerts (disaster_id, title, message) VALUES (?, ?, ?)',
      [alertData.disaster_id, alertData.title, alertData.message],
      callback
    );
  },

  update: (id, alertData, callback) => {
    db.query(
      'UPDATE alerts SET disaster_id=?, title=?, message=? WHERE id=?',
      [alertData.disaster_id, alertData.title, alertData.message, id],
      callback
    );
  },

  delete: (id, callback) => {
    db.query('DELETE FROM alerts WHERE id=?', [id], callback);
  },
};

module.exports = Alert;