test_that("connects and disconnects to duckdb in memory", {
  con <- claims_connect(dbdir = ":memory:")
  expect_equal(con@driver@dbdir, ":memory:")
  expect_setequal(DBI::dbListTables(con), names(claimsdb_tables()))
  expect_true(inherits(con, "duckdb_connection"))
  expect_true(DBI::dbIsValid(con))
  claims_disconnect(con)
  expect_false(DBI::dbIsValid(con))
})

test_that("connects and disconnects to duckdb using dbdir file", {
  con <- claims_connect(dbdir = claims_db())
  db_file <- con@driver@dbdir
  expect_true(inherits(con, "duckdb_connection"))
  expect_true(basename(db_file) == "claims.duckdb")

  expect_true(DBI::dbIsValid(con))
  claims_disconnect(con)
  expect_false(DBI::dbIsValid(con))
  expect_false(file.exists(dirname(db_file)))
})

test_that("claims_db() creates a temporary copy of the database", {
  file <- claims_db()
  on.exit(unlink(dirname(file), recursive = TRUE))

  expect_true(basename(file) == "claims.duckdb")
  expect_true(file.exists(file))
  expect_true(grepl("claims", dirname(file)))
})
