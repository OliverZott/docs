# Crossbar.io and Wamp

## Crossbar.io

- Crossbar.io is an open source networking platform for distributed and microservice applications
- Crossbar.io is a WAMP router
- Crossbar.io is an implementation of the open Web Application Messaging Protocol (WAMP)
- Crossbar.io is agnostic to the implementation of the client or its deployment
- [Getting Started](https://crossbar.io/docs/Getting-Started/)
- [DockerHub](https://hub.docker.com/r/crossbario/crossbar)

Semantics:

- **Node** Controller
  - The node controller is the master process of everything. The node controller reads the configuration file locally and starts multiple worker processes such as router, containers and guest workers
- **Router**
  - Routers are the core facilities of Crossbar.io, responsible for routing WAMP remote procedure calls between Callers and Callees, as well as routing WAMP publish-subscribe events between Publishers and Subscribers.
  - To start a router the following things needs to be defined.
    - **Realm**
    - **Transport**
- **Realm**
  - is equivalent to a namespace. Crossbar.io uses realms as domains for separation of routing and administration
  - The router needs to provide at least one realm for applications to communicate through

- **Transport**
  - Transports are necessary for allowing incoming connections to Routers
  - Crossbar.io provides WebSocket and RawSocket Transport
  
---

## WAMP / WampSharp

- WAMP (*Web Application Messaging Protocol*) is a **WebSocket** subprotocol specified to offer routed **[RPC](https://en.wikipedia.org/wiki/Remote_procedure_call)** and **[Publish–subscribe](<https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern>)** pattern.
- WAMP requires a full-duplex message channel as a transport layer, and by default uses Websocket.
- The minimum requirements to build a WAMP client are the abilities to use sockets and to serialise to JSON.
- **WampSharp** is a .NET open source implementation of WAMP which allows you to write RPC services and Pub/Sub based applications.
- [WAMP](https://wamp-proto.org/)
- [repo](https://github.com/Code-Sharp/WampSharp)
- [Getting started](https://wampsharp.net/wamp2/getting-started-with-wampv2/)

WAMP (Web Application Messaging Protocol) is an open application level protocol that provides two messaging patterns:

- Remote Procedure Calls
  - <https://de.wikipedia.org/wiki/Remote_Procedure_Call>
- Publish & Subscribe
  - <https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern>

## Semantics

- **Caller**
  - A role that can *call* a remote procedure call registered by a Callee (using the `CALL` messages).
  - The caller can *receive* a response with a result or an error from the router (using the `RESULT/ERROR` message).
- **Callee**
  - A role that can *register* a remote procedure call to the route (using the `REGISTER/UNREGISTER` messages)
  - The callee’s procedure can *be invoked* by the router (using the `INVOCATION` message).
  - The callee can *respond* with a result or an error to the router (using the YIELD/ERROR message).
- **Subscriber**
  - A role that can subscribe to a WAMP realm’s topic.
  - The subscriber will be notified about events published to the topic by publishers.
- **Publisher**
  - A role that can publish events to a WAMP realm’s topic.

- **Topics** [[link]](https://wampsharp.net/wamp1/server-pubsub-hosting-wampv1/#about-topics)
  - Topics are **rx Subjects**, that means that they are both **observable** and **observers**. That means you can both **subscribe** to them and send them messages.
  - **ReactiveX** ...  implementation of reactive programming (e.g. rxjs) [link](https://en.wikipedia.org/wiki/ReactiveX) [link rxjs](https://rxjs.dev/guide/overview)
  - **Subject** ...sort of bridge or proxy [...]  acts both as an Observer and as an Observable [link](https://reactivex.io/documentation/subject.html)

- **Realm** ...

---

## Remarks

- RPC
- Websocket
- Pub/Sub pattern
- Message Broker
- Reactive Programming
