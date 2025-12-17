 import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import Quiz from 'ember-latest/components/quiz';


module('Integration | Component | quiz', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const model = {
      title: 'Test Quiz',
      questions: [
        {
          id: 'q1',
          text: 'Question?',
          options: [{ id: 'o1', text: 'Option 1' }],
          correctOptionIds: ['o1'],
        },
      ],
    };

    await render(<template>
      <Quiz @model={{model}} />
    </template>);

    assert.dom('h1').includesText('Test Quiz');
  });
});
