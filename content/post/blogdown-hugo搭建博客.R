
# 参考 http://www.sohu.com/a/220909022_500658

# install.packages('blogdown')
# devtools::install_github("rstudio/blogdown")

require(blogdown)

# 安装hugo  force = TRUE to reinstall or upgrade.
blogdown::install_hugo()
blogdown::update_hugo()


blogdown:::serve_site()  #运行站点
