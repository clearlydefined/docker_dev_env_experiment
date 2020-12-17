db.createUser(
  {
    user : "admin",
    pwd : "secret",
    roles : [
      {
        role : "readWrite",
        db : "clearlydefined"
      }
    ]
  }
)
