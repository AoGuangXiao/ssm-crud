# ssm-crud
尚硅谷SSM框架实战(不如改成Ajax教学)：完成对用户信息的增删改查。

按照B站尚硅谷框架练习视频完成的Demo，使用了bootstrap，jQuery前端框架，Spring，Springmvc，mybatis后端框架，MySQL数据库，tomcat7.0服务器。
创建的是Maven工程，通过修改pom文件进行导包，使用Git进行版本控制，并上传至github。使用了mybatis逆向工程生成mapper，对于额外的需求直接在生成的mapper中
添加/修改即可，提升了开发效率。

缺点：该Demo中所有的请求都是使用Ajax的方式，响应返回的都是json字符串，所有进行了大量jQuery代码的编写，而后端框架代码的编写比较少。
