<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Добавляем поле для приватности трекеров
            if (!Schema::hasColumn('users', 'trackers_privacy')) {
                $table->string('trackers_privacy')
                    ->default('друзья')
                    ->after('quote')
                    ->comment('только я, друзья, все');
            }
            
            // Добавляем поле для приватности постов
            if (!Schema::hasColumn('users', 'posts_privacy')) {
                $table->string('posts_privacy')
                    ->default('все')
                    ->after('trackers_privacy')
                    ->comment('только я, друзья, все');
            }
            
            // Добавляем поле для аватара
            if (!Schema::hasColumn('users', 'avatar_url')) {
                $table->string('avatar_url')
                    ->nullable()
                    ->after('posts_privacy')
                    ->comment('путь к файлу аватара');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Удаляем поля при откате миграции
            $columns = ['trackers_privacy', 'posts_privacy', 'avatar_url'];
            
            foreach ($columns as $column) {
                if (Schema::hasColumn('users', $column)) {
                    $table->dropColumn($column);
                }
            }
        });
    }
};
