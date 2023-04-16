FROM cypress/base:10
 
WORKDIR /app
COPY . /app 

RUN npm install cypress
RUN $(npm bin)/cypress verify

CMD npm run test:search; \
npm run cucumber:report

