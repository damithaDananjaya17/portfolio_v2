#Use an official Node.js runtime as the base image 
FROM node:14 as build

#Set the working directory in the container 
WORKDIR /app

#Copy package.json and package-lock.json 
COPY package*.json ./

#Install project dependencies 
RUN npm install

#Copy the entire project to the container 
COPY . .

#Build the React app 
RUN npm run build

# Use a lightweight Node.js runtime for serving the app 
FROM node:14-slim

#Set the working directory 
WORKDIR /app

#Copy only the built files from the previous stage 
COPY --from=build /app/build

#Install serve globally to serve the application 
RUN npm install -g serve

#Expose the port on which the application will run 
EXPOSE 80

#Command to serve the application 
CMD ["serve", "-s", ".", "-p", "80"]
