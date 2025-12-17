import { module, test } from 'qunit';
import { setupTest } from 'ember-latest/tests/helpers';

module('Unit | Service | quiz', function (hooks) {
  setupTest(hooks);

  // TODO: Replace this with your real tests.
  test('it exists', function (assert) {
    const service = this.owner.lookup('service:quiz');
    assert.ok(service);
  });
});
