const db = require('../config/db');

const SOS = {
  getAll: (callback) => {
    db.query('SELECT * FROM sos_requests', callback);
  },

  getById: (id, callback) => {
    db.query('SELECT * FROM sos_requests WHERE id = ?', [id], callback);
  },

  create: (sosData, callback) => {
    db.query(
      'INSERT INTO sos_requests (user_id, latitude, longitude, status) VALUES (?, ?, ?, ?)',
      [sosData.user_id, sosData.latitude, sosData.longitude, sosData.status || 'PENDING'],
      callback
    );
  },

  update: (id, sosData, callback) => {
    db.query(
      'UPDATE sos_requests SET user_id=?, latitude=?, longitude=?, status=? WHERE id=?',
      [sosData.user_id, sosData.latitude, sosData.longitude, sosData.status, id],
      callback
    );
  },

  delete: (id, callback) => {
    db.query('DELETE FROM sos_requests WHERE id=?', [id], callback);
  },
};

module.exports = SOS;