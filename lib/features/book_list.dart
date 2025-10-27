import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/book_provider.dart';

class BookListScreen extends ConsumerWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBooks = ref.watch(popularBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Books')),
      body: asyncBooks.when(
        data: (books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              leading: book.thumbnail.isNotEmpty
                  ? Image.network(book.thumbnail, width: 50)
                  : const Icon(Icons.book),
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: book.rating > 0
                  ? Text('⭐ ${book.rating.toStringAsFixed(1)}')
                  : null,
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
