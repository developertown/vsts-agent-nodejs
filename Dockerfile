FROM developertown/vsts-agent:2.105.2-1

WORKDIR /usr/local/vsts-agent

ENV NODE_VERSION_LTS=4.4.5 \
    NODE_VERSION_CURRENT=6.2.2 \
    node=/usr/local/vsts-agent/.nodenv/shims/node \
    npm=/usr/local/vsts-agent/.nodenv/shims/npm \
    grunt=/usr/local/vsts-agent/.nodenv/shims/grunt \
    mocha=/usr/local/vsts-agent/.nodenv/shims/mocha \
    gulp=/usr/local/vsts-agent/.nodenv/shims/gulp \
    PATH=/usr/local/vsts-agent/.nodenv/shims:/usr/local/vsts-agent/.nodenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

USER vsts

RUN \
     git clone https://github.com/nodenv/nodenv.git ~/.nodenv \
  && cd ~/.nodenv && src/configure && make -C src \
  && echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc \
  && echo 'eval "$(nodenv init -)"' >> ~/.bashrc \
  && export PATH="$HOME/.nodenv/bin:$PATH" \
  && eval "$(nodenv init -)" \
  && git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build \
  && nodenv install ${NODE_VERSION_LTS} \
  && nodenv local ${NODE_VERSION_LTS} \
  && npm install -g grunt \
  && npm install -g mocha \
  && npm install -g gulp \
  && nodenv install ${NODE_VERSION_CURRENT} \
  && nodenv global ${NODE_VERSION_CURRENT} \
  && npm install -g grunt \
  && npm install -g mocha \
  && npm install -g gulp

ENV AGENT_FLAVOR=NodeJS
