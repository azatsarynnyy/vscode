FROM node:10.16-alpine
ENV PORT 5000
ADD . /usr/bin/vscode
RUN mkdir /projects /usr/bin/vscode && \
    # Change permissions to let any arbitrary user
    for f in "${HOME}" "/etc/passwd" "/projects" "/usr/bin/vscode"; do \
      echo "Changing permissions on ${f}" && \
      chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done
ADD etc/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
EXPOSE 5000
# USER 1000
WORKDIR /usr/bin/vscode
CMD ["yarn", "web"]
