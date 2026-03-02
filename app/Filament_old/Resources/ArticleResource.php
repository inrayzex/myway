<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ArticleResource\Pages;
use App\Filament\Resources\ArticleResource\RelationManagers;
use App\Models\Article;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ArticleResource extends Resource
{
    protected static ?string $model = Article::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    public static function form(Form $form): Form
{
    return $form
        ->schema([
            Forms\Components\TextInput::make('title')
                ->label('Заголовок')
                ->required()
                ->maxLength(255),
            Forms\Components\RichEditor::make('content')
                ->label('Содержание')
                ->required()
                ->columnSpanFull(),
            Forms\Components\Textarea::make('excerpt')
                ->label('Краткое описание')
                ->maxLength(65535)
                ->columnSpanFull(),
            Forms\Components\Select::make('category')
                ->label('Категория')
                ->options([
                    'meditation' => 'Медитация',
                    'yoga' => 'Йога',
                    'philosophy' => 'Философия',
                    'nutrition' => 'Питание',
                    'mindfulness' => 'Осознанность',
                ])
                ->required(),
            Forms\Components\TextInput::make('author')
                ->label('Автор')
                ->maxLength(255),
            Forms\Components\TextInput::make('read_time')
                ->label('Время чтения (мин)')
                ->numeric(),
            Forms\Components\Select::make('difficulty')
                ->label('Сложность')
                ->options([
                    'легкая' => 'Лёгкая',
                    'средняя' => 'Средняя',
                    'сложная' => 'Сложная',
                ]),
            Forms\Components\FileUpload::make('image_url')
                ->label('Изображение')
                ->image()
                ->directory('articles'),
        ]);
}

    public static function table(Table $table): Table
{
    return $table
        ->columns([
            Tables\Columns\TextColumn::make('title')
                ->label('Заголовок')
                ->searchable(),
            Tables\Columns\TextColumn::make('category')
                ->label('Категория'),
            Tables\Columns\TextColumn::make('author')
                ->label('Автор'),
            Tables\Columns\TextColumn::make('read_time')
                ->label('Время чтения')
                ->suffix(' мин'),
            Tables\Columns\IconColumn::make('has_image')
                ->label('Фото')
                ->boolean()
                ->getStateUsing(fn ($record): bool => !empty($record->image_url)),
            Tables\Columns\TextColumn::make('created_at')
                ->label('Создано')
                ->dateTime(),
        ])
        ->filters([
            Tables\Filters\SelectFilter::make('category')
                ->options([
                    'meditation' => 'Медитация',
                    'yoga' => 'Йога',
                    'philosophy' => 'Философия',
                    'nutrition' => 'Питание',
                ]),
        ])
        ->actions([
            Tables\Actions\EditAction::make(),
            Tables\Actions\DeleteAction::make(),
        ])
        ->bulkActions([
            Tables\Actions\BulkActionGroup::make([
                Tables\Actions\DeleteBulkAction::make(),
            ]),
        ]);
}

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListArticles::route('/'),
            'create' => Pages\CreateArticle::route('/create'),
            'edit' => Pages\EditArticle::route('/{record}/edit'),
        ];
    }
}
