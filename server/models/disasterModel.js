const db = require('../config/db');

const Disaster = {
  getAll: (callback) => {
    db.query('SELECT * FROM disasters', callback);
  },

  getById: (id, callback) => {
    db.query('SELECT * FROM disasters WHERE id = ?', [id], callback);
  },

  create: (disasterData, callback) => {
    db.query(
      'INSERT INTO disasters (disaster_type, description, latitude, longitude, danger_radius, severity) VALUES (?, ?, ?, ?, ?, ?)',
      [disasterData.disaster_type, disasterData.description, disasterData.latitude, disasterData.longitude, disasterData.danger_radius, disasterData.severity],
      callback
    );
  },

  update: (id, disasterData, callback) => {
    db.query(
      'UPDATE disasters SET disaster_type=?, description=?, latitude=?, longitude=?, danger_radius=?, severity=? WHERE id=?',
      [disasterData.disaster_type, disasterData.description, disasterData.latitude, disasterData.longitude, disasterData.danger_radius, disasterData.severity, id],
      callback
    );
  },

  delete: (id, callback) => {
    db.query('DELETE FROM disasters WHERE id=?', [id], callback);
  },
};

module.exports = Disaster;