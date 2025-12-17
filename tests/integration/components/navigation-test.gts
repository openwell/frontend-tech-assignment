// @ts-nocheck
import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import type { TestContext } from '@ember/test-helpers';
import Navigation from 'ember-latest/components/navigation';

interface NavigationTestContext extends TestContext {
  onPrevious: () => void;
  onNext: () => void;
}

module('Integration | Component | navigation', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (
    this: NavigationTestContext,
    assert
  ) {
    this.setProperties({
      onPrevious() {},
      onNext() {},
    });

    await render(<template>
      <Navigation
        @hasSelection={{true}}
        @onPrevious={{this.onPrevious}}
        @onNext={{this.onNext}}
      />
    </template>);

    assert.dom('button').exists();
  });
});
