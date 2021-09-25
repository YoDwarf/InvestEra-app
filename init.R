my_packages = "magrittr"

install_if_missing = function(p) {
  if(p %in% rownames(installed.packages())) {
    install.packages(p)
  }
}

install.packages("shinyMobile_0.9.1.tar.gz", repos=NULL, type="source")

invisible(sapply(my_packages, install_if_missing))
