FROM cbeams/vanitygen
WORKDIR /iexec
COPY vanity-with-consensus.sh /iexec/vanity-with-consensus.sh
RUN chmod +x /iexec/vanity-with-consensus.sh
ENTRYPOINT ["/iexec/vanity-with-consensus.sh"]