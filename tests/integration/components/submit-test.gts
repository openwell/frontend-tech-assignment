import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-latest/tests/helpers';
import { render } from '@ember/test-helpers';
import Submit from 'ember-latest/components/submit';

module('Integration | Component | submit', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const quizData = {
      title: 'Sample quiz',
      questions: [
        {
          id: 'q1',
          text: 'Question 1',
          options: [{ id: 'o1', text: 'Option 1' }],
          correctOptionIds: ['o1'],
        },
      ],
    };
    const selectedAnswers: Record<string, string[]> = { q1: ['o1'] };
    const onSubmit = () => {};

    await render(<template>
      <Submit
        @quizData={{quizData}}
        @selectedAnswers={{selectedAnswers}}
        @onSubmit={{onSubmit}}
      />
    </template>);

    assert.dom().includesText('Question 1');
  });
});
