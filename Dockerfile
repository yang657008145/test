# 使用Node.js镜像作为基础镜像
FROM node:14

# 设置工作目录
WORKDIR /app

# 将 package.json 和 package-lock.json 文件复制到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 将项目文件复制到工作目录
COPY . .

# 构建项目
RUN npm run build

# 使用Nginx镜像作为基础镜像
FROM nginx:1.21.1

# 将Vue项目构建的静态文件复制到Nginx中
COPY --from=0 /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80
