import { module, test } from 'qunit';
import { setupTest } from 'ember-latest/tests/helpers';

module('Unit | Route | quiz', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const route = this.owner.lookup('route:quiz');
    assert.ok(route);
  });
});
