import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing'; 

interface IndexSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Index"}}
  
  <LinkTo @route="quiz">Quiz</LinkTo>
</template> satisfies TOC<IndexSignature>;
