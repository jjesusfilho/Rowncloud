# listFiles.R
#' Function to list files from a folder in owncloud
#' 
#' copyryig (c) 2016, José de Jesus Filho
#' last modified Nov, 2016
#'  
#'  This program is free software; you can redistribute it and/or
#     modify it under the terms of the GNU General Public License,
#     version 3, as published by the Free Software Foundation.
#
#     This program is distributed in the hope that it will be useful,
#     but without any warranty; without even the implied warranty of
#     merchantability or fitness for a particular purpose.  See the GNU
#     General Public License, version 3, for more details.
#
#     A copy of the GNU General Public License, version 3, is available
#     at http://www.r-project.org/Licenses/GPL-3
#' 
#' This functions allows you to list your files at your owncloud account
#' @param 
#' username your user name
#' password your password
#' uri your owncloud address without http
#' dir  the directory or path contaning the sequences of directories where your files are
#' file.type the extension of the files. By default the function will list all files
#' @keywords owncloud list files
#' @export
#' @examples
#' listFiles(username="me",password="mypassword",uri="cloud.josejesus.info/remote.php/webdav/",dir="myfolder",file.type=".pdf")

listFiles<-function(username,password,uri="cloud.josejesus.info/remote.php/webdav/",dir="",file.type=""){
  library(httr)
  library(xml2)
  library(stringr)
  url<-paste0("http://",username,":",password,"@",uri,dir)
  s1<-VERB("PROPFIND",url)
  s2<-content(s1,"parsed")
  s3<-xml_find_all(s2,".//d:href")
  s4<-xml_text(s3)
  s5<-str_extract(s4,paste0("[^/]*",file.type,"$"))
  s6<-na.exclude(s5)
  return(s6)
}
# end of listFiles.R