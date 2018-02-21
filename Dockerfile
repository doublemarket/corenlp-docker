FROM java:jre-alpine

RUN apk add --update --no-cache unzip wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-01-31.zip
RUN unzip stanford-corenlp-full-2018-01-31.zip
RUN rm stanford-corenlp-full-2018-01-31.zip
RUN ln -s stanford-corenlp-full-2018-01-31 stanford-corenlp
WORKDIR stanford-corenlp
RUN ln -s stanford-corenlp-3.9.0.jar stanford-corenlp.jar
#RUN wget https://nlp.stanford.edu/software/stanford-postagger-full-2018-01-31.zip
#RUN ln -s stanford-postagger-full-2018-01-31 taggers
RUN wget https://github.com/louismullie/stanford-core-nlp/raw/master/bin/bridge.jar
RUN wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-01-31-models.jar
RUN ln -s stanford-english-corenlp-2018-01-31-models.jar english-models.jar
RUN wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2018-01-31-models.jar
RUN ln -s stanford-english-kbp-corenlp-2018-01-31-models.jar english-kbp-models.jar

RUN export CLASSPATH="`find . -name '*.jar'`"

EXPOSE 9000
CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9000 -timeout 15000

