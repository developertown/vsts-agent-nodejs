FROM developertown/vsts-agent:2.102.0

WORKDIR /usr/local/vsts-agent

ENV NODE_VERSION_LTS=4.4.5
ENV NODE_VERSION_CURRENT=6.2.2

ENV node=/usr/local/vsts-agent/.nodenv/shims/node
ENV npm=/usr/local/vsts-agent/.nodenv/shims/npm
ENV grunt=/usr/local/vsts-agent/.nodenv/shims/grunt
ENV mocha=/usr/local/vsts-agent/.nodenv/shims/mocha
ENV gulp=/usr/local/vsts-agent/.nodenv/shims/gulp

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
  && npm install -g gulp
  && nodenv install ${NODE_VERSION_CURRENT} \
  && nodenv global ${NODE_VERSION_CURRENT} \
  && npm install -g grunt \
  && npm install -g mocha \
  && npm install -g gulp

