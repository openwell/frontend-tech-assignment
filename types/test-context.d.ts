import '@ember/test-helpers';

declare module '@ember/test-helpers' {
  interface TestContext {
    [key: string]: unknown;
  }
}

