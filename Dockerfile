FROM maven:3.9.11-eclipse-temurin-25 AS builder
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
# Chỉ lấy file .jar từ builder (GĐ1)
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
# Chạy ứng dụng (dùng CMD để tránh bị ghi đè bởi image cũ)
CMD ["java", "-jar", "app.jar"]