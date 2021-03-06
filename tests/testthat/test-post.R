test_that("archetypes use hugo or whisker templating", {
  skip_if_no_hugo()

  site <- local_dir(test_path("archetypes"))
  dir_create(path(site, "content", "Rmd"))
  dir_create(path(site, "content", "md"))

  test_Rmd <- use_post("Rmd/test", site = site, open = FALSE)
  test_md <- use_post("md/test", site = site, open = FALSE)

  rmd <- brio::read_lines(path(test_Rmd, "index.Rmd"))
  expect_equal(rmd[[2]], "slug: test")

  md <- brio::read_lines(path(test_md, "index.md"))
  expect_equal(md[[2]], "slug: test")
})

test_that("catch common errors", {
  skip_if_no_hugo()

  site <- local_dir(test_path("archetypes"))
  expect_error(use_post("Rmd/test", site = site), "Can't find")

  dir_create(path(site, "content", "Rmd"))
  use_post("Rmd/test", site = site, open = FALSE)
  expect_error(use_post("Rmd/test", site = site), "already exists")
})
