CI 增强项目. 目的是配合 Jenkins 完成方便检索构建结果和管理构建的系统.

web 目录是 flutter 实现的前端. server 是 SpringBoot 实现的后端. 分布式编译采用 Jenkins Node 模式. 

# web

### 构建
建议使用 `./flutterw` 开发和构建项目, 这样可以保证环境一致.

```shell
# debug
./flutterw run -d chrome

# build
./flutterw build web
```

# server
```shell
# List all history
curl 'localhost:8080/history?ver=1.0.0.100&buildType=debug&category=preview&page=0'

# Synchronize from jenkins
# `from` is unix-timestamp, optional
curl -X POST -H 'Content-Type: application/x-www-form-urlencoded' 'localhost:8080/history/sync?from=1606460110'
```

### TODO
* 数据库
  - docker
  - mysql, 建表
* 业务逻辑
  - 查询构建任务
