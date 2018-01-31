FROM java:jre-alpine

RUN apk add --update --no-cache unzip wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2017-06-09.zip
RUN unzip stanford-corenlp-full-2017-06-09.zip
RUN rm stanford-corenlp-full-2017-06-09.zip
RUN ln -s stanford-corenlp-full-2017-06-09 stanford-corenlp
WORKDIR stanford-corenlp
RUN ln -s stanford-corenlp-3.8.0.jar stanford-corenlp.jar
RUN wget https://nlp.stanford.edu/software/stanford-postagger-full-2017-06-09.zip
RUN ln -s stanford-postagger-full-2017-06-09 taggers
RUN wget https://github.com/louismullie/stanford-core-nlp/raw/master/bin/bridge.jar
RUN wget http://nlp.stanford.edu/software/stanford-english-corenlp-2017-06-09-models.jar
RUN ln -s stanford-english-corenlp-2017-06-09-models.jar english-models.jar
RUN wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2017-06-09-models.jar
RUN ln -s stanford-english-kbp-corenlp-2017-06-09-models.jar english-kbp-models.jar

RUN export CLASSPATH="`find . -name '*.jar'`"

EXPOSE 9000
CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9000 -timeout 15000

