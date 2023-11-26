module ICU4XFixedDecimalGroupingStrategy;

import modules.diplomat_runtime;

enum ICU4XFixedDecimalGroupingStrategy
{
  ICU4XFixedDecimalGroupingStrategy_Auto = 0,
  ICU4XFixedDecimalGroupingStrategy_Never = 1,
  ICU4XFixedDecimalGroupingStrategy_Always = 2,
  ICU4XFixedDecimalGroupingStrategy_Min2 = 3,
}
extern (C)
{

  void ICU4XFixedDecimalGroupingStrategy_destroy(ICU4XFixedDecimalGroupingStrategy* self);

} // extern (C)
