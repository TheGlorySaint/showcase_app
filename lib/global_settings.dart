const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
const kIsDev = flavor == 'dev';
const kIsProd = flavor == 'prod';
