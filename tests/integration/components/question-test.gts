import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import Question from 'ember-latest/components/question';

module('Integration | Component | question', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const question = {
      id: 'q1',
      text: 'Sample question',
      options: [],
      correctOptionIds: [],
    };
    const selectedOptions: string[] = [];
    const noop = () => {};

    await render(
      <template>
        <Question
          @question={{question}}
          @selectedOptions={{selectedOptions}}
          @onUpdateSelection={{noop}}
          @currentQuestionNumber={{1}}
          @totalQuestions={{1}}
        />
      </template>
    );

    assert.dom('h2').includesText('Sample question');
  });
});
