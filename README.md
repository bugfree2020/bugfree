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

记得要将改动同步到 server:
```shell
# 假设当前目录是 web
rm -rf ../server/src/main/resources/static
mkdir -p ../server/src/main/resources/static 
cp -r ./build/web/* ../server/src/main/resources/static
```

# server
```shell
# List all history
curl 'localhost:8080/history?ver=1.0.0.100&buildType=debug&category=preview&page=0'

# List all main version, for example: [1.59.0, 1.60.0, 1.60.1]
curl 'localhost:8080/history/version'

# Synchronize from jenkins
# `from` is unix-timestamp, optional
curl -X POST -H 'Content-Type: application/x-www-form-urlencoded' 'localhost:8080/history/sync?from=1606460110'
```

###  Jenkins 同步
现阶段 RD 直接使用 jenkins 打包, 然而 QA 使用 bugfree 查看构建历史. 因此会涉及到 jenkins 打包后要同步 bugfree 服务器. 目前的解法是每次 jenkins 打包后会通知 bugfree 服务器对其同步. 

目前整个流程处于过渡阶段, 二期工作会统一使用 bugfree 进行打包和历史管理, jenkins 只作为构建工具存在. 


### TODO
* 数据库
  - docker
  - mysql, 建表
* 业务逻辑
  - 查询构建任务
