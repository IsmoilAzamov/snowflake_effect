
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:my_ihma/client/presentation/bloc/login/register/register_event.dart';
import 'package:my_ihma/core/widgets/app_bar.dart';

import '../../../../core/widgets/beautiful_error_widget.dart';
import '../../../../core/widgets/client_contractor_tabbar.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../di/di.dart';
import '../../bloc/login/register/register_bloc.dart';
import '../../bloc/login/register/register_state.dart';
import 'client_form.dart';
import 'contractor_frorm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int tabIndex = 0;
  final _bloc = sl<RegisterBloc>();

  List<TypeEntity> documentTypes = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(InitRegisterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CurvedAppBar(title: 'register'.tr()),
        body: BlocConsumer<RegisterBloc, RegisterState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is RegisterLoadedState) {
                documentTypes = state.documentTypes;
              }
            },
            builder: (context, state) {
              return _buildStateWidget(state);
            }));
  }

  Widget _buildStateWidget(RegisterState state) {
    if (state is RegisterLoadedState) {
      return _loadedUI();
    } else if (state is RegisterLoadingState) {
      return LoadingIndicator();
    }
    return _buildErrorState(state);
  }

  Widget _buildErrorState(RegisterState state) {
    return FluidErrorWidget(
      message: state is RegisterErrorState ? state.message : "something_went_wrong".tr(),
      onRetry: () => _bloc.add(InitRegisterEvent()),
    );
  }

  Widget _loadedUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 8),
          ClientContractorTabBar(
            onTabChanged: (index) {
              tabIndex = index;
              setState(() {});
            },
          ),
          [
            ClientRegisterForm(documentTypes: documentTypes),
            ContractorRegisterForm(),
          ][tabIndex],
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}



