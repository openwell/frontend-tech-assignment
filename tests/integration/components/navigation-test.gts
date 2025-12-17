import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import Navigation from 'ember-latest/components/navigation';

module('Integration | Component | navigation', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><Navigation /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <Navigation>
        template block text
      </Navigation>
    </template>);

    assert.dom().hasText('template block text');
  });
});
