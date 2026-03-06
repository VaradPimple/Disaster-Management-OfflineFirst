module.exports = (req, res, next) => {
  console.log("Auth middleware working");
  next();
};