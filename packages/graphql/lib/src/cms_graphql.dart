import 'package:graphql/client.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_cms_graphql/src/service/cms_graphql_client_service.dart';
import 'package:utopia_cms_graphql/src/service/cms_graphql_service.dart';

class CmsGraphQL {
  static const instance = CmsGraphQL();

  const CmsGraphQL();

  CmsGraphQLService get service => const CmsGraphQLService();
  CmsGraphQLClientService get clientService => const CmsGraphQLClientService();

  GraphQLClient createClient(
    String uri, {
    String header = 'Authorization',
    Future<String?> Function()? tokenProvider,
    Reporter? reporter,
  }) => clientService.createClient(uri, header: header, tokenProvider: tokenProvider, reporter: reporter);
}
