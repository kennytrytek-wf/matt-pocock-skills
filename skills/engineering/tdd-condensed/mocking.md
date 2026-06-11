# When to Mock

Mock at **system boundaries** only:

• External APIs (payment, email) • Databases (sometimes — prefer test DB) • Time/randomness • File system (sometimes)

Don't mock: your own classes/modules · internal collaborators · anything you control

## Designing for Mockability

**1. Dependency injection** — pass deps in, don't create internally:

```typescript
// Easy to mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// Hard to mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. SDK-style over generic fetchers** — specific functions per operation:

```typescript
// GOOD: Each function is independently mockable
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// BAD: Mocking requires conditional logic inside the mock
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK approach: one shape per mock · no conditional test setup · visible endpoints · type safety per endpoint
