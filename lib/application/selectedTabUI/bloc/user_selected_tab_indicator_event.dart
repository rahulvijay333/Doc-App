part of 'user_selected_tab_indicator_bloc.dart';

class UserSelectedTabIndicatorEvent {}

class SelectSlotIndicator extends UserSelectedTabIndicatorEvent {
  final bool isSelected;

  SelectSlotIndicator(this.isSelected);
}

class ClearSlotIndicator extends UserSelectedTabIndicatorEvent {
  final bool isSelected;

  ClearSlotIndicator(this.isSelected);
}
