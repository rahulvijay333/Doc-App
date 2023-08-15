part of 'navbar_bloc.dart';

 class NavbarEvent {}

 class PageChangeEvent extends NavbarEvent{
  final int page;

  PageChangeEvent( {required this.page});
 }
